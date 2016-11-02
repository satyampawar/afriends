module Paperclip
  class FileContents < Processor
    def initialize file, options = {}, attachment = nil
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @current_format = File.extname(attachment.instance.pic_file_name)
      @basename       = File.basename(@file.path, @current_format)
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
      @options[:format] = @current_format
    end

    def make
      begin
        # new record, set contents attribute by reading the attachment file
          @file.rewind # move pointer back to start of file in case handled by other processors
          file_content = File.read(@file.path)
          secured_keys=SecuredKey.last
          encrypted_file_content = AES.encrypt(file_content, secured_keys.key, {:iv => secured_keys.salt})

          file = File.open(@file.path,"w")
          file.write(file_content)
          tmp = Tempfile.new([@basename, @current_format].compact.join("."))
          tmp << encrypted_file_content
          tmp.flush 
          @file = tmp
          @file
      rescue StandardError => e
        puts e
        #raise PaperclipError, "There was an error processing the file contents for #{@basename} - #{e}" if @whiny
      end
    end
  end
end
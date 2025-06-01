require 'docx' 
require 'securerandom'

class Public::FontConvertersController < ApplicationController

  def read_docx
    uploaded_file = params[:file]
    if uploaded_file.blank?
      return render json: { error: 'No file provided' }, status: :bad_request
    end

    begin
      tmp_path = uploaded_file.tempfile.path
      if File.exist?(tmp_path)
        doc = Docx::Document.open(uploaded_file.tempfile.path)
        text = doc.paragraphs.map(&:text).join("\n")
      render json: { content: text }, status: :ok
      else
        render json: { error: 'File not found or invalid' }, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: e.message }, status: 500
    ensure
      File.delete(tmp_path) if tmp_path && File.exist?(tmp_path)
    end
  end

  def write_docx
    text = params[:text]
    if text.blank?
      render json: { error: 'No text provided' }, status: :unprocessable_entity
      return
    end

    tmp_path = Rails.root.join("tmp/#{SecureRandom.hex(8)}.docx")
    require 'caracal'
    Caracal::Document.save(tmp_path.to_s) do |docx|
      docx.p text
    end

    send_file tmp_path,
      filename: 'generated.docx',
      type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      disposition: 'attachment'
  end

end

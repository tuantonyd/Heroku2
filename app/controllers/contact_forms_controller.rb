class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      @contact_form.request = request
      if @contact_form.deliver
        respond_to do |format|
          format.html { redirect_to new_contact_form_path, notice: "Thank you for your message!"}
        end
      else
        respond_to do |format|
          format.html { redirect_to new_contact_form_path, alert: @contact_form.errors.full_messages}
        end
      end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end
end

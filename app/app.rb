module CodeafterhoursPadrino
  class App < Padrino::Application

    enable :sessions

    set :public_folder, File.dirname(__FILE__) + '/public'

    get '/' do
        send_file File.expand_path('index.html', settings.public_folder)
    end

    get '/bayamon' do
        send_file File.expand_path('bay.html', settings.public_folder)
    end

    get '/sanjuan' do
        send_file File.expand_path('sj.html', settings.public_folder)
    end

    get '/done' do
        send_file File.expand_path('done.html', settings.public_folder)
    end

    post '/send_email' do
      options = {
      :to => 'info@ens-labs.com',
      :from => params[:email],
      :subject => 'Code After hours',
      :body => params[:message],
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
        }
      }
      
      Pony.mail(options)
      
      redirect '/done'
    end

  end
end

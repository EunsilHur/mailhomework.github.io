class HomeController < ApplicationController
  def index
     @posts = Post.all
  end
   def write
    post = Post.new
    post.title = params[:title]
    post.fromemail = params[:email]
    post.content = params[:content]
    post.save
   

    mg_client = Mailgun::Client.new("key-74c2af48100e8c62fc4f5f27e43e741f")

    message_params =  {
                   from: 'bob@example.com',
                   to:    post.fromemail,
                   subject: post.title,
                   text:  post.content
                  }

    result = mg_client.send_message('mg.emailemail.com', message_params).to_h!

    message_id = result['id']
    message = result['message']
    
    redirect_to '/'
  end
   def destroy
    one_post = Post.find(params[:p_id])
    one_post.destroy
    
    redirect_to '/'
  end
   def show
    one_post = Post.find(params[:p_id])
    @title=one_post.title
    @content=one_post.content
    @senddate=one_post.created_at.in_time_zone("Asia/Seoul").strftime("%Y-%m-%d %H:%M:%S")
    @getemail=one_post.fromemail
    
  end
end

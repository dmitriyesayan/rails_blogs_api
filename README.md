Blog API
Deployed at https://rails-blog-api11.herokuapp.com/api/v1/

POSTS

  GET all posts
    
    https://blogsapi.herokuapp.com/api/v1/posts
  GET a post
    
    https://blogsapi.herokuapp.com/api/v1/posts/:id
  POST a post
    
    https://blogsapi.herokuapp.com/api/v1/posts
    
    Header:
      key: Content-Type
      value: application/json
    Body format (raw):
      { "post": { "content": "new post" } }
   PATCH a post
    
      https://blogsapi.herokuapp.com/api/v1/posts/:id
    
      Header:
        key: Content-Type
        value: application/json
      Body format (raw):
        { "post": { "content": "updated content" } }
  
  DELETE a post
     
     https://blogsapi.herokuapp.com/api/v1/posts/:id
     
     Header:
        key: Content-Type
        value: application/json

COMMENTS

   GET all comments
       
       https://blogsapi.herokuapp.com/api/v1/posts/:id/comments
       
   GET a commment
       
       https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id
   
   POST a comment
       
       https://blogsapi.herokuapp.com/api/v1/posts/:id/comments
       
       Header:
        key: Content-Type
        value: application/json
       Body format (raw):
        { "comment": { "content": "new comment" } }
        
   PATCH a comment
       
       https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id
       
       Header:
        key: Content-Type
        value: application/json
       Body format (raw):
        { "comment": { "content": "updated comment" } }
        
   DELETE a comment
        
        https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id
        
        Header:
         key: Content-Type
         value: application/json
 
 SUBCOMMENTS
 
   GET all subcomments

     https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id/subcomments

   GET a subcomment

     https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id/subcomments/:id
   POST a subcomment

     https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id/subcomments

     Header:
      key: Content-Type
      value: application/json
     Body format (raw):
      { "subcomment": { "content": "new subcomment" } }
      
  PATCH a subcomment
    
    https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id/subcomments/:id
    
    Header:
    key: Content-Type
    value: application/json
    Body format (raw):
    { "subcomment": { "content": "updated subcomment" } }
    
  DELETE a subcomment
   
     https://blogsapi.herokuapp.com/api/v1/posts/:id/comments/:id/subcomments/:id
     
     Header:
     key: Content-Type
     value: application/json

Running locally:
   
    bundle install
    rails db:create
    rails db:migrate
    rails s # to run on localhost:3000
    # API lives in /api/v1
 
 Testing:
   
     rspec

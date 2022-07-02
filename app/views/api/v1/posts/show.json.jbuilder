json.extract! @post, :id, :content
json.comments @post.comments do |comment|
  json.extract! comment, :id, :content
  json.subcomments comment.subcomments do |subcomment|
    json.extract! subcomment, :id, :content
  end
end

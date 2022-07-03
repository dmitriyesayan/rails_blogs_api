json.extract! @comment, :id, :content, :post_id
json.subcomments @comment.subcomments do |subcomment|
  json.extract! subcomment, :id, :content
end

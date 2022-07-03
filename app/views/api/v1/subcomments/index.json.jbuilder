json.array! @subcomments do |subcomment|
  json.extract! subcomment, :id, :content, :comment_id
end

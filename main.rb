result = Posts.find(:all, :order => "id desc", :limit =>5)

	while ! result.empty?
		@feeds= result.pop
end
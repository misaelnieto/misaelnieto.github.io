Jekyll::Hooks.register :site, :post_read do |site|
  # Define the directories to search for images
  image_directories = ['assets/images', 'images', '_posts']

  # Initialize the image count
  image_count = 0

  # Supported image extensions
  image_extensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.svg', '.webp']

  # Iterate through the specified directories
  image_directories.each do |dir|
    Dir.glob(File.join(site.source, dir, '**', '*')) do |file|
      if image_extensions.include?(File.extname(file).downcase)
        image_count += 1
      end
    end
  end

    # Initialize the draft count
    draft_count = 0

    # Path to the _drafts directory
    drafts_dir = File.join(site.source, '_drafts')
  
    # Check if the _drafts directory exists
    if Dir.exist?(drafts_dir)
      # Count the number of markdown files in the _drafts directory
      draft_count = Dir.glob(File.join(drafts_dir, '**', '*.{md,markdown}')).size
    end

    site.config['stats'] = {
        'posts' => site.posts.size,
        'drafts' => draft_count,
        'pages' => site.pages.size,
        'Images' => image_count
      }
end

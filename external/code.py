import os
from PIL import Image

# Directory where the files are located
directory = "../thumbnails/"
# New directory for compressed images
output_directory = "../thumbnails_compressed/"
# Maximum size in KB
max_size_kb = 20

# Ensure the output directory exists
if not os.path.exists(output_directory):
    os.makedirs(output_directory)

# Function to compress an image to be under a specified size in KB
def compress_image(file_path, output_path, max_size_kb):
    img = Image.open(file_path)

    # Resize the image to width=250px while maintaining the aspect ratio
    width = 250
    aspect_ratio = img.height / img.width
    height = int(width * aspect_ratio)
    img = img.resize((width, height))

    # Start with high quality and optimize the image
    quality = 95
    while True:
        # Save the image with reduced quality and optimization
        img.save(output_path, "JPEG", quality=quality, optimize=True)
        
        # Check file size
        if os.path.getsize(output_path) <= max_size_kb * 1024:
            break
        
        # Decrease quality for further compression
        quality -= 5
        if quality < 10:
            break  # Stop if quality goes too low
    
    print(f"Compressed: {file_path} -> {output_path}")

# Iterate through all .jpg files in the directory
for filename in os.listdir(directory):
    file_path = os.path.join(directory, filename)

    # Check if the file is a .jpg and its size exceeds the threshold
    if filename.lower().endswith(".jpg") and os.path.getsize(file_path) > max_size_kb * 1024:
        # Create a new file path for the compressed image in the new directory
        output_path = os.path.join(output_directory, filename)
        compress_image(file_path, output_path, max_size_kb)

print("Compression complete.")

import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array
from PIL import Image

# Load OpenCL kernel source code from file
def load_kernel_source(filename):
    with open(filename, 'r') as file:
        return file.read()

# Load an image from file
def load_image(filename):
    img = Image.open(filename).convert('L')  # Convert to grayscale
    return np.array(img, dtype=np.uint8)

# Save an image to file
def save_image(filename, img):
    Image.fromarray(img).save(filename)

# Main function
def main():
    # Load OpenCL kernel source
    kernel_source = load_kernel_source('sobel.cl')

    # Load input image
    input_image = load_image('cica.jpg')

    # Initialize OpenCL
    platform = cl.get_platforms()[0]
    device = platform.get_devices()[0]
    context = cl.Context([device])
    queue = cl.CommandQueue(context)

    # Create OpenCL program
    program = cl.Program(context, kernel_source).build()

    # Allocate memory for input and output images on the device
    input_buffer = cl_array.to_device(queue, input_image)
    output_buffer = cl_array.empty(queue, input_image.shape, dtype=np.uint8)

    # Execute the kernel
    program.sobel(queue, input_image.shape, None, input_buffer.data, output_buffer.data)

    # Copy the result back to the host
    output_image = output_buffer.get()

    # Save the output image
    save_image('output_image.jpg', output_image)

if __name__ == '__main__':
    main()

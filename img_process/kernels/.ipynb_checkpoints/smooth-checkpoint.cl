__kernel void edge_smooth(__global const uchar* input_image, __global uchar* output_image, const int width, const int height) {
    int x = get_global_id(0);
    int y = get_global_id(1);
    int idx = y * width + x;
    int channels = 3; 
    
    int r = 0, g = 0, b = 0;
    
    // Iterate over the neighboring pixels for edge smoothing
    for (int dx = -1; dx <= 1; ++dx) {
        for (int dy = -1; dy <= 1; ++dy) {
            int sx = clamp(x + dx, 0, width - 1);
            int sy = clamp(y + dy, 0, height - 1);
            int sidx = sy * width + sx;
            r += input_image[sidx * channels];
            g += input_image[sidx * channels + 1];
            b += input_image[sidx * channels + 2];
        }
    }
    
    // Compute the average color
    r /= 9;
    g /= 9;
    b /= 9;
    
    // Write the result to the output image
    output_image[idx * channels] = r;
    output_image[idx * channels + 1] = g;
    output_image[idx * channels + 2] = b;
}

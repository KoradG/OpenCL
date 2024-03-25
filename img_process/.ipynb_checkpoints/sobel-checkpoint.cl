// sobel.cl
__kernel void sobel(__global const uchar* input_image, __global uchar* output_image, const int width, const int height) {
    int x = get_global_id(0);
    int y = get_global_id(1);
    int idx = y * width + x;
    int gx = 0, gy = 0;
    int offset = 1;
    if (x > 0 && x < width - 1 && y > 0 && y < height - 1) {
        gx = -1 * input_image[(y - 1) * width + x - 1] + input_image[(y - 1) * width + x + 1]
            - 2 * input_image[y * width + x - 1] + 2 * input_image[y * width + x + 1]
            - 1 * input_image[(y + 1) * width + x - 1] + input_image[(y + 1) * width + x + 1];
        gy = -1 * input_image[(y - 1) * width + x - 1] - 2 * input_image[(y - 1) * width + x] - 1 * input_image[(y - 1) * width + x + 1]
            + input_image[(y + 1) * width + x - 1] + 2 * input_image[(y + 1) * width + x] + input_image[(y + 1) * width + x + 1];
        output_image[idx] = (uchar)(sqrt((float)(gx * gx + gy * gy)));
    } else {
        output_image[idx] = 0;
    }
}

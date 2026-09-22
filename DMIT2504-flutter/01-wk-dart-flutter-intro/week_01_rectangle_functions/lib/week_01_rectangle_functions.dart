/// Returns the surface area of rectangle with [width], [length], and [height]
///
/// Throws an [Exception] any of [width], [length], or [height] are zero or
/// negative
int surfaceArea(int width, int length, int height) {
  if (width <= 0 || length <= 0 || height <= 0) {
    throw Exception('Width, length, and height must be positive');
  }

  return (2 * width * height) + (2 * width * length) + (2 * width * length);
}

/// Returns the volume of a rectable with given [width], [length]
/// and [height]
///
/// Throws an [Exception] if either [width], [length], or [height] are not
/// positive
int volume(int width, int length, int height) {
  if (width <= 0 || length <= 0 || height <= 0) {
    throw Exception('Width, length, and height must be positive');
  }

  return width * length * height;
}

T? castOrNull<T>(dynamic value) => value is T ? value : null;

T? tryOrNull<T>(T Function() block) {
  try {
    return block();
  } catch (e) {
    return null;
  }
}


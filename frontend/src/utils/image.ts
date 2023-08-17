export const getImagePreloader = () => {
  const imageCache: Set<string> = new Set();

  return (images: string[]) => {
    images.forEach((src) => {
      // 중복 preload 방지
      if (imageCache.has(src)) return;

      const image = new Image();
      image.src = src;
      imageCache.add(src);
    });
  };
};

export const preloadImage = (images: string[]) => {
  return Promise.all([
    ...images.map(
      (src) =>
        new Promise((res, rej) => {
          const image = new Image();
          image.src = src;
          image.onload = res;
          image.onerror = rej;
        }),
    ),
  ]);
};

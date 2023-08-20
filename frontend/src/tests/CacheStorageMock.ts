class Cache {
  cache: Map<string, Response>;
  constructor() {
    this.cache = new Map();
  }

  async match(url: string) {
    console.log(url);
    // mock 이기 때문에 무조건 null 을 반환합니다.
    return null;
  }

  async put(url: string, response: Response) {
    this.cache.set(url, response);
  }
}

export class CacheStorageMock {
  caches: Map<string, Cache>;
  constructor() {
    this.caches = new Map();
  }

  async open(cacheName: string) {
    if (!this.caches.has(cacheName)) {
      this.caches.set(cacheName, new Cache());
      return this.caches.get(cacheName) as Cache;
    }
    return this.caches.get(cacheName) as Cache;
  }
}

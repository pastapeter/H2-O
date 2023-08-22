async function request<TResponse>(url: string, options: RequestInit = {}): Promise<TResponse> {
  const baseUrl = `${import.meta.env.VITE_API_BASE_URL}${url}`;

  const cacheStorage = await caches.open('cache');
  const cachedResponse = await cacheStorage.match(url);

  if (cachedResponse && !isCacheExpired(cachedResponse)) {
    return cachedResponse.json();
  }

  const res = await fetch(baseUrl, options);
  if (res.status !== 200) {
    throw new Error(`${res.status} 에러가 발생했습니다.`);
  }

  if (options.method === 'GET') {
    const responseWithDate = await getResponseWithDate(res);
    await cacheStorage.put(url, responseWithDate);
  }

  const json = await res.json();
  return json;
}

function get<TResponse>(url: string, options?: RequestInit) {
  return request<TResponse>(url, {
    method: 'GET',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
    ...options,
  });
}

function post<TBody, TResponse>(url: string, body: TBody) {
  return request<TResponse>(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(body),
  });
}

async function getResponseWithDate(_response: Response) {
  const response = _response.clone();
  const body = await response.blob();
  const headers = new Headers(response.headers);
  headers.append('fetch-date', new Date().toISOString());

  return new Response(body, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

const CACHE_EXPIRE_TIME = 1000 * 60 * 60 * 24;

function isCacheExpired(response: Response) {
  const fetchedDate = new Date(response.headers.get('fetch-date') as string).getTime();
  const today = new Date().getTime();

  return today - fetchedDate > CACHE_EXPIRE_TIME;
}

export const api = {
  get,
  post,
};

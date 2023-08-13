async function request<TResponse>(url: string, options: RequestInit = {}): Promise<TResponse> {
  const baseUrl = url;

  const res = await fetch(baseUrl, options);
  if (res.status !== 200) {
    throw new Error(`${res.status} 에러가 발생했습니다.`);
  }

  const json = await res.json();
  return json;
}

function get<TResponse>(url: string, options?: RequestInit) {
  return request<TResponse>(url, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    },
    ...options,
  });
}

function post<TBody extends BodyInit, TResponse>(url: string, body: TBody) {
  return request<TResponse>(url, {
    method: 'POST',
    body,
  });
}

export const api = {
  get,
  post,
};

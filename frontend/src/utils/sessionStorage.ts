export const getSessionStorageItem = (key: string) => {
  return sessionStorage.getItem(key);
};

export const setSessionStorageItem = (key: string, value: string) => {
  sessionStorage.setItem(key, value);
};

export const removeSessionStorageItem = (key: string) => {
  sessionStorage.removeItem(key);
};

export const hasSessionStorageItem = (key: string) => {
  return sessionStorage.getItem(key) !== null;
};

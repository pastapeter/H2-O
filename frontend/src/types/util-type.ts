export type LowerCaseKeys<T> = {
  [K in keyof T as K extends string ? Lowercase<K> : never]: T[K];
};

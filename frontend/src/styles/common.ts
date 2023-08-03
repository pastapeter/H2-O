export const FLEX = {
  flexDefault: {
    display: 'flex',
  },
  flexCenterCol: {
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
  },
  flexCenterRow: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  flexBetweenCol: {
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'space-between',
  },
  flexBetweenRow: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
} as const;

export type FlexType = typeof FLEX;
export type FlexVariant = keyof FlexType;

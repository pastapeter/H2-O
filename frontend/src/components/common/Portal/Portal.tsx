import type { PropsWithChildren } from 'react';
import { useRef } from 'react';
import { createPortal } from 'react-dom';
import { useMounted } from '@/hooks';

interface Props {
  targetElementId?: string;
}

function Portal({ children, targetElementId = 'portal-root' }: PropsWithChildren<Props>) {
  const elementRef = useRef<HTMLElement | null>(null);
  const mounted = useMounted();

  elementRef.current = document.getElementById(targetElementId);

  if (!mounted || !elementRef.current) return null;

  return createPortal(children, elementRef.current);
}

export default Portal;

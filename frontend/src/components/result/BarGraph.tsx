import { SalesBar } from './utils';
import { Flex } from '@/components/common';

interface Props {
  salesCount: number;
  quotationSalesCount: number[];
}

const MAX_HEIGHT = 90;

function BarGraph({ salesCount, quotationSalesCount }: Props) {
  const totalSalesCount = [...quotationSalesCount, salesCount];

  const maxCount = Math.max(...totalSalesCount);

  return (
    <Flex justifyContent='center' alignItems='flex-end' gap={20} width='100%'>
      <SalesBar key={5} isQuotation={false} salesCount={salesCount} height={MAX_HEIGHT * (salesCount / maxCount)} />
      {quotationSalesCount.map((count, idx) => (
        <SalesBar key={idx} salesCount={count} height={MAX_HEIGHT * (count / maxCount)} />
      ))}
    </Flex>
  );
}

export default BarGraph;

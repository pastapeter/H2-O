import styled from '@emotion/styled';
import type { DefaultOptionResponse } from '@/types/interface';
import { OptionCard } from '@/components/option/utils';

interface Props {
  dataList: DefaultOptionResponse[];
  handleClickOptionCard: (idx: number, hasHMGData: boolean) => () => void;
}

function DefaultOptionSelector({ dataList, handleClickOptionCard }: Props) {
  return (
    <OptionContainer>
      {dataList.map((opt) => (
        <OptionCard key={opt.id} info={opt} onClick={handleClickOptionCard(opt.id, opt.containsHmgData)} />
      ))}
    </OptionContainer>
  );
}

export default DefaultOptionSelector;

const OptionContainer = styled.div`
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  gap: 16px;
`;

import styled from '@emotion/styled';
import ModelTypeCard, { Props as Option } from './ModelTypeCard';
import { Flex, Typography } from '@/components/common';

interface Props {
  name: string;
  selectedIdx: number;
  options?: Option[];
  onSelect: (idx: number) => void;
}

function ModelTypeOptionList({ name, selectedIdx, options = [], onSelect }: Props) {
  return (
    <Flex flexDirection='column'>
      <Typography font='HeadKRMedium14' color='gray600' marginBottom={4}>
        {name}
      </Typography>
      <OptionContainer as='ul' gap={5}>
        {options.map(({ name, ...props }, idx) => (
          <ModelTypeCard
            as='li'
            key={name}
            isSelected={selectedIdx === idx}
            name={name}
            onClick={() => onSelect(idx)}
            {...props}
          />
        ))}
      </OptionContainer>
    </Flex>
  );
}

export default ModelTypeOptionList;

const OptionContainer = styled(Flex)`
  background-color: ${({ theme }) => theme.colors.gray50};
  border-radius: 8px;
  padding: 4px;
`;

import { useBackend } from 'tgui/backend';
import { Button, Icon, Section } from 'tgui/components';
import { Window } from 'tgui/layouts';

export const ElevatorPanel = (props, context) => {
  const { data, act } = useBackend(context);
  const { areDoorsOpen, current, options } = data;
  return (
    <Window width={270} height={220}>
      <Section>
        Этаж: {current.label} - {current.name}
      </Section>
      <Section>
        <table width="100%">
          {options.map((option) => (
            <tr key={option.ref}>
              <td>{current.ref === option.ref && <Icon name="chevron-right" />}</td>
              <td>
                <Button
                  fluid
                  disabled={!!option.queued}
                  color={!!option.queued && 'yellow'}
                  content={`${option.label} - ${option.name}`}
                  onClick={() => act('move_to_floor', { ref: option.ref })}
                />
              </td>
                <td>{current.ref === option.ref && <Icon name="chevron-left" />}</td>
            </tr>
          ))}
        </table>
      </Section>
      <Section>
        <Button disabled={areDoorsOpen} p={0} onClick={() => act('open_doors')} tooltip="Открыть двери">
          <Icon name="expand-alt" size={2} m={1} />
        </Button>
        <Button disabled={!areDoorsOpen} p={0} onClick={() => act('close_doors')} tooltip="Закрыть двери">
          <Icon name="compress-alt" size={2} m={1} />
        </Button>
        <Button color="red" p={0} onClick={() => act('emergency_stop')} tooltip="Экстренная остановка">
          <Icon name="exclamation-triangle" size={2} m={1} />
        </Button>
      </Section>
    </Window>
  );
};

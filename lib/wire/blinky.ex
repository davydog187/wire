defmodule Wire.Blinky do
  use GenServer

  # Durations are in milliseconds
  @on_duration 200
  @off_duration 200

  alias Circuits.GPIO
  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [18])
  end

  def blink(pin) when is_reference(pin) do
    GPIO.write(pin, 1)
    :timer.sleep(@on_duration)
    GPIO.write(pin, 0)
    :timer.sleep(@off_duration)
  end

  def init(pins) do
    {:ok, switch} = Circuits.GPIO.open(25, :input)
    :ok = Circuits.GPIO.set_interrupts(switch, :rising)

    leds =
      for pin <- pins do
        {:ok, led} = GPIO.open(pin, :output)
        GPIO.write(led, 0)
        led
      end

    {:ok, %{leds: leds, timer: nil, switch: switch}}
  end

  def handle_info({:circuits_gpio, 25, _timestamp, _value}, state) do
    timer =
      if state.timer do
        :timer.cancel(state.timer)
        nil
      else
        {:ok, timer} = :timer.send_interval(1000, :blink)
        timer
      end

    {:noreply, %{state | timer: timer}}
  end

  def handle_info(:blink, state) do
    for led <- state.leds, do: blink(led)

    {:noreply, state}
  end

  # defp flip_state({led, current}) do
  #   next =
  #     case current do
  #       0 -> 1
  #       1 -> 0
  #     end

  #   Circuits.GPIO.write(led, next)

  #   {led, next}
  # end
end

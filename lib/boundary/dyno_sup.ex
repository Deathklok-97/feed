defmodule Boundary.DynamicSession do
  use GenServer

  def child_spec({quiz, email}) do
    %{
      id: {__MODULE__, {quiz.title, email}},
      start: {__MODULE__, :start_link, [{quiz, email}]},
      restart: :temporary
    }
  end

  def start_link({quiz, email}) do
    GenServer.start_link(
      __MODULE__,
      {quiz, email},
      name: via({quiz.title, email})
    )
  end

  def take_quiz(quiz, email) do
    DynamicSupervisor.start_child(
      Boundary.DynamicSession,
      {__MODULE__, {quiz, email}}
    )
  end

  def via({_title, _email} = name) do
    {:via, Registry, {Registry.DynamicSession, name}}
  end

  defp maybe_finish(nil, _email) do
    {:stop, :normal, :finished, nil}
  end

  defp maybe_finish(quiz, email) do
    {:reply, {quiz.current_question.asked, quiz.last_response.correct}, {quiz, email}}
  end

  def select_question(name) do
    GenServer.call(via(name), :select_question)
  end

  def answer_question(name, answer) do
    GenServer.call(via(name), {:answer_question, answer})
  end

  def active_sessions_for(quiz_title) do
    Mastery.Supervisor.QuizSession
    |> DynamicSupervisor.which_children()
    |> Enum.filter(&child_pid?/1)
    |> Enum.flat_map(&active_sessions(&1, quiz_title))
  end

  defp child_pid?({:undefined, pid, :worker, [__MODULE__]}) when is_pid(pid), do: true
  defp child_pid?(_child), do: false

  defp active_sessions({:undefined, pid, :worker, [__MODULE__]}, title) do
    Mastery.Registry.QuizSession
    |> Registry.keys(pid)
    |> Enum.filter(fn {quiz_title, _email} ->
      quiz_title == title
    end)
  end

  def end_sessions(names) do
    Enum.each(names, fn name -> GenServer.stop(via(name)) end)
  end

  @impl GenServer
  def init({quiz, email}) do
    {:ok, {quiz, email}}
  end

end

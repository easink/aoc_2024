defmodule AoC.Day09 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse_line()
    |> parse_files()
    |> defrag()
    |> calc_crc()
  end

  def part2(filename) do
    filename
    |> parse_line()
    |> parse_files()
    |> defrag_contiguous()
    |> calc_crc()
  end

  defp parse_line(filename) do
    filename
    |> File.read!()
    |> String.trim_trailing()
    |> to_charlist()
    |> Enum.map(&(&1 - ?0))
  end

  defp calc_crc(files, n \\ 0, acc \\ 0)

  defp calc_crc([{_file_id, 0} | files], n, acc), do: calc_crc(files, n, acc)
  defp calc_crc([{:empty, len} | files], n, acc), do: calc_crc([{:empty, len - 1} | files], n + 1, acc)

  defp calc_crc([{file_id, len} | files], n, acc),
    do: calc_crc([{file_id, len - 1} | files], n + 1, n * file_id + acc)

  defp calc_crc([], _n, acc), do: acc

  def move_file(front, {file_id, len}, back, n) do
    Enum.split_while(front, fn
      {:empty, empty_len} when empty_len >= len -> false
      {:empty, _empty_len} -> true
      {_file_id, _len} -> true
    end)
    |> case do
      {f, [{:empty, ^len} | b]} ->
        {n - 1, f ++ [{file_id, len} | b], [{:empty, len} | back]}

      {f, [{:empty, empty_len} | b]} ->
        {n, f ++ [{file_id, len}, {:empty, empty_len - len} | b], [{:empty, len} | back]}

      {f, []} ->
        {n - 1, f, [{file_id, len} | back]}
    end
  end

  defp defrag_contiguous(layout) do
    defrag_contiguous(layout, length(layout) - 1, [])
  end

  defp defrag_contiguous([], _n, back), do: back

  defp defrag_contiguous(front, n, back) do
    {front, [b]} = Enum.split(front, n)

    case {front, b} do
      {front, {:empty, _n}} ->
        defrag_contiguous(front, n - 1, [b | back])

      {_front, _b} ->
        {n, front, back} = move_file(front, b, back, n)
        defrag_contiguous(front, n, back)
    end
  end

  defp defrag(layout), do: defrag(layout, Enum.reverse(layout), [])

  defp defrag(_front, [{:empty, _} | back], acc), do: defrag(Enum.reverse(back), back, acc)
  defp defrag([{:empty, 0} | front], _back, acc), do: defrag(front, Enum.reverse(front), acc)

  defp defrag([{:empty, empty_len} | front], _back, acc) do
    back = Enum.reverse(front)
    [{file_id, file_len} | back] = back

    cond do
      file_len > empty_len ->
        sub = {file_id, file_len - empty_len}
        back = [sub | back]
        front = Enum.reverse(back)
        add = {file_id, empty_len}
        acc = [add | acc]
        defrag(front, back, acc)

      file_len == empty_len ->
        front = Enum.reverse(back)
        add = {file_id, file_len}
        acc = [add | acc]
        defrag(front, back, acc)

      file_len < empty_len ->
        front = Enum.reverse(back)
        front = [{:empty, empty_len - file_len} | front]
        back = Enum.reverse(front)
        add = {file_id, file_len}
        acc = [add | acc]
        defrag(front, back, acc)
    end
  end

  defp defrag([file | front], _back, acc) do
    back = Enum.reverse(front)
    defrag(front, back, [file | acc])
  end

  defp defrag([], _back, acc), do: Enum.reverse(acc)

  defp parse_files(line, acc \\ [], id \\ 0)

  defp parse_files([], acc, _id), do: Enum.reverse(acc)

  defp parse_files([file_size, empty_size | line], acc, id) do
    acc = [{id, file_size} | acc]
    acc = if empty_size == 0, do: acc, else: [{:empty, empty_size} | acc]
    parse_files(line, acc, id + 1)
  end

  defp parse_files([file_size | line], acc, id) do
    parse_files(line, [{id, file_size} | acc], id + 1)
  end
end

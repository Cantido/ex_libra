defmodule ExLibra do
  @moduledoc """
  Documentation for `ExLibra`.
  """

  @doc """
  Fetch the avatar URL for an email address.
  """
  def avatar(email, opts \\ []) do
    email_domain = String.split(email, "@") |> Enum.at(1)

    email_hash =
      :crypto.hash(:md5, String.downcase(email))
      |> Base.encode16(case: :lower)

    answers =
      try do
        DNS.query("_avatars-sec._tcp.#{email_domain}", :srv).anlist
      rescue
        _ -> []
      end

    avatar_host =
      if Enum.empty?(answers) do
        "seccdn.libravatar.org"
      else
        Enum.at(answers, 0).data
      end

    query_params =
      Keyword.take(opts, [:size, :default])
      |> rename_keys(%{size: "s", default: "d", force_default: "f"})
      |> URI.encode_query()

    "https://#{avatar_host}/avatar/#{email_hash}?#{query_params}"
  end

  defp rename_keys(map, names) do
    Map.new(map, fn {old_key, val} ->
      {Map.get(names, old_key, old_key), val}
    end)
  end
end

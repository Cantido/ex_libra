defmodule ExLibra do
  @moduledoc """
  Documentation for `ExLibra`.
  """

  @doc """
  Fetch the avatar URL for an email address.

  ## Options

    * `:size` - size of the resulting image, between 1 and 512
    * `:default` - URL to a default image to use, or a special value for an auto-generated avatar
    * `:force_default` - force the default image to be displayed, even if an avatar exists for this email
    * `:scheme` - `:http` or `:https`, default is `:https`
  """
  def avatar(email, opts \\ []) do
    scheme = Keyword.get(opts, :scheme, :https)
    email_domain = String.split(email, "@") |> Enum.at(1)

    email_hash =
      :crypto.hash(:md5, String.downcase(email))
      |> Base.encode16(case: :lower)

    answers =
      try do
        case scheme do
          :https -> DNS.query("_avatars-sec._tcp.#{email_domain}", :srv).anlist
          :http -> DNS.query("_avatars._tcp.#{email_domain}", :srv).anlist
        end
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

    "#{Atom.to_string(scheme)}://#{avatar_host}/avatar/#{email_hash}?#{query_params}"
  end

  defp rename_keys(map, names) do
    Map.new(map, fn {old_key, val} ->
      {Map.get(names, old_key, old_key), val}
    end)
  end
end

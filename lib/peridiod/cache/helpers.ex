defmodule Peridiod.Cache.Helpers do
  defmacro __using__(opts) do
    quote do
      import Peridiod.Utils, only: [stamp_utc_now: 0]
      alias Peridiod.Cache

      @cache_path unquote(opts[:cache_path])
      @cache_file unquote(opts[:cache_file])
      @stamp_cached ".stamp_cached"
      @stamp_installed ".stamp_installed"

      def cache_path(%{prn: prn}) do
        cache_path(prn)
      end

      def cache_path(prn) when is_binary(prn) do
        Path.join([@cache_path, prn])
      end

      def cached?(cache_pid \\ Cache, metadata) do
        stamp_file = Path.join([cache_path(metadata), @stamp_cached])
        Cache.exists?(cache_pid, stamp_file)
      end

      def installed?(cache_pid \\ Cache, metadata) do
        stamp_file = Path.join([cache_path(metadata), @stamp_installed])
        Cache.exists?(cache_pid, stamp_file)
      end

      def stamp_cached(cache_pid \\ Cache, metadata) do
        stamp_file = Path.join([cache_path(metadata), @stamp_cached])
        Cache.write(cache_pid, stamp_file, stamp_utc_now())
      end

      def stamp_installed(cache_pid \\ Cache, metadata) do
        stamp_file = Path.join([cache_path(metadata), @stamp_installed])
        Cache.write(cache_pid, stamp_file, stamp_utc_now())
      end
    end
  end
end
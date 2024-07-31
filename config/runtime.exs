import Config

shell =
  System.find_executable("bash") || System.find_executable("zsh") || System.find_execurtable("sh")

System.put_env("SHELL", shell)

log_level =
  case System.get_env("PERIDIO_LOG_LEVEL") do
    "debug" -> :debug
    "warning" -> :warning
    "info" -> :info
    _ -> :error
  end

kv_backend =
  case System.get_env("PERIDIOD_KV_BACKEND") do
    "filesystem" -> PeridiodPersistence.KVBackend.Filesystem
    "ubootenv" -> PeridiodPersistence.KVBackend.UBootEnv
    _ -> PeridiodPersistence.KVBackend.UBootEnv
  end

config :peridiod_persistence,
  kv_backend: kv_backend

config :logger, level: log_level

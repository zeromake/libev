includes("check_cincludes.lua")
includes("check_csnippets.lua")
includes("check_cfuncs.lua")
includes("check_ctypes.lua")

add_rules("mode.debug", "mode.release")

target("ev")
  set_kind("$(kind)")
  set_configdir("$(buildir)/generate")
  add_includedirs("$(buildir)/generate")
  add_configfiles("src/config.h.in")

  configvar_check_cincludes("HAVE_SYS_INOTIFY_H", "sys/inotify.h")
  configvar_check_cincludes("HAVE_SYS_EPOLL_H", "sys/epoll.h")
  configvar_check_cincludes("HAVE_SYS_EVENT_H", "sys/event.h")
  configvar_check_cincludes("HAVE_PORT_H", "port.h")
  configvar_check_cincludes("HAVE_POLL_H", "poll.h")
  configvar_check_cincludes("HAVE_SYS_TIMERFD_H", "sys/timerfd.h")

  configvar_check_cincludes("HAVE_SYS_SELECT_H", "sys/select.h")
  configvar_check_cincludes("HAVE_SYS_EVENTFD_H", "sys/eventfd.h")
  configvar_check_cincludes("HAVE_SYS_SIGNALFD_H", "sys/signalfd.h")
  configvar_check_cincludes("HAVE_LINUX_AIO_ABI_H", "linux/aio_abi.h")
  configvar_check_cincludes("HAVE_LINUX_FS_H", "linux/fs.h")

  configvar_check_cfuncs("HAVE_INOTIFY_INIT", "inotify_init", {includes={"sys/inotify.h"}})
  configvar_check_cfuncs("HAVE_EPOLL_CTL", "epoll_ctl", {includes={"sys/epoll.h"}})
  configvar_check_cfuncs("HAVE_KQUEUE", "kqueue", {includes={"sys/event.h"}})
  configvar_check_cfuncs("HAVE_PORT_CREATE", "port_create", {includes={"port.h"}})
  configvar_check_cfuncs("HAVE_POLL", "poll", {includes={"poll.h"}})
  configvar_check_cfuncs("HAVE_SELECT", "select", {includes={"sys/select.h"}})
  configvar_check_cfuncs("HAVE_EVENTFD", "eventfd", {includes={"sys/eventfd.h"}})
  configvar_check_cfuncs("HAVE_SIGNALFD", "signalfd", {includes={"sys/signalfd.h"}})
  configvar_check_cfuncs("HAVE_CLOCK_GETTIME", "clock_gettime", {includes={"time.h"}})
  configvar_check_cfuncs("HAVE_NANOSLEEP", "nanosleep", {includes={"time.h"}})
  configvar_check_cfuncs("HAVE_FLOOR", "floor", {includes={"math.h"}})

  configvar_check_ctypes("HAVE_KERNEL_RWF_T", "__kernel_rwf_t", {includes={"linux/fs.h"}})

  configvar_check_csnippets("HAVE_CLOCK_SYSCALL", [[
#include <unistd.h>
#include <sys/syscall.h>
#include <time.h>
int test() {
    struct timespec ts;
    int status = syscall(SYS_clock_gettime, CLOCK_REALTIME, &ts);
}]])

  add_files(
    "src/ev.c",
    "src/event.c"
  )
  add_headerfiles(
    "src/ev.h",
    "src/ev++.h",
    "src/event.h"
  )
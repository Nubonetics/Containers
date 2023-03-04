FROM nvidia/cudagl:10.2-devel-ubuntu18.04

COPY ade/env.sh /etc/profile.d/ade_env.sh
COPY ade/entrypoint /tmp/ade_entrypoint

ENTRYPOINT ["/tmp/ade_entrypoint"]
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]

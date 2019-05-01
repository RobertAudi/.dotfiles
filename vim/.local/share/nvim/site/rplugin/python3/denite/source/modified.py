from .base import Base
from denite import util
import subprocess
import os

class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'modified'
        self.kind = 'file'

    def on_init(self, context):
        cbname = self.vim.current.buffer.name
        context['__cbname'] = cbname
        context['__root_path'] = util.path2project(self.vim, cbname, context.get('root_markers', ''))

    def gather_candidates(self, context):
        cmd = ["git", "status", "--porcelain"]
        if not self._is_git_merge_or_rebase(context['__root_path']):
            cmd.append("--untracked-files=all")

        statuslines = subprocess.run(
                cmd,
                check=True,
                universal_newlines=True,
                stdout=subprocess.PIPE
                ).stdout.splitlines()

        return [{'word': path[3:], 'abbr': path} for path in statuslines]

    def _is_git_merge_or_rebase(self, root_path):
        gitdir = os.path.join(root_path, ".git")
        return (os.path.isfile(os.path.join(gitdir, "MERGE_HEAD")) or
                os.path.isdir(os.path.join(gitdir, "rebase-merge")) or
                os.path.isdir(os.path.join(gitdir, "rebase-apply")) or
                os.path.isfile(os.path.join(gitdir, "CHERRY_PICK_HEAD")))

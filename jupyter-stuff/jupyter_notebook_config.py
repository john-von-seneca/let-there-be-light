import io
import os
from notebook.utils import to_api_path

_script_exporter = None

def script_post_save(model, os_path, contents_manager, **kwargs):
    """convert notebooks to Python script after save with nbconvert

    replaces `ipython notebook --script`
    """
    from nbconvert.exporters.script import ScriptExporter

    if model['type'] != 'notebook':
        return

    global _script_exporter

    if _script_exporter is None:
        _script_exporter = ScriptExporter(parent=contents_manager)

    log = contents_manager.log

    base, ext = os.path.splitext(os_path)
    py_fname = base + '.py'
    script, resources = _script_exporter.from_filename(os_path)
    script_fname = base + resources.get('output_extension', '.txt')
    log.info("Saving script /%s", to_api_path(script_fname, contents_manager.root_dir))

    with io.open(script_fname, 'w', encoding='utf-8') as f:
        f.write(script)

import subprocess
def html_toc_post_save(model, os_path, contents_manager, **kwargs):
    print(os_path, "fuck")
    # subprocess.call(["jupyter", "nbconvert", "--to", "html_toc", os_path])
    subprocess.call(["jupyter", "nbconvert", "--to", "html_with_toclenvs", os_path])
 
c.FileContentsManager.post_save_hook = html_toc_post_save


source ~/pwndbg/gdbinit.py
source ~/Pwngdb/pwngdb.py
source ~/Pwngdb/angelheap/gdbinit.py

set backtrace limit 3

# For Pwngdb heap libraries
define hook-run
python
import angelheap
angelheap.init_angelheap()
end
end
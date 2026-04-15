### LVS Note
- LVS did not reach a final compare pass because of a ground-pin naming mismatch.
- The schematic uses `VSS_CORE`, while the layout side was reading only `VSS`.
- This was a naming-convention issue, so the netlists were not compared successfully within the available time.

* LVS run was attempted but Calibre RVE could not display the results due to the **XDB database being unavailable**, reporting "No comparison was made" in the viewer.
* Multiple **"Duplicate subckt"** warnings were encountered at runtime, indicating the same subcircuit definitions appeared more than once in the source netlist — likely due to overlapping cell includes from the standard cell and pad library during netlist generation.
* These were a netlist cleanliness issue, so the LVS comparison could not be formally completed within the available time.

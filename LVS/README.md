### LVS Note
- LVS did not reach a final compare pass because of a ground-pin naming mismatch.
- The schematic uses `VSS_CORE`, while the layout side was reading only `VSS`.
- This was a naming-convention issue, so the netlists were not compared successfully within the available time.

x64:
    remap "__imp_videoThunk32" "__imp_avicap32$videoThunk32"
    remap "__imp_capGetDriverDescriptionW" "__imp_avicap32$capGetDriverDescriptionW"
    remap "__imp_capGetDriverDescriptionA" "__imp_avicap32$capGetDriverDescriptionA"
    remap "__imp_capCreateCaptureWindowW" "__imp_avicap32$capCreateCaptureWindowW"
    remap "__imp_capCreateCaptureWindowA" "__imp_avicap32$capCreateCaptureWindowA"
    remap "__imp_AppCleanup" "__imp_avicap32$AppCleanup"
x86:
    remap "__imp__videoThunk32@20" "__imp__avicap32$videoThunk32@20"
    remap "__imp__capGetDriverDescriptionW@20" "__imp__avicap32$capGetDriverDescriptionW@20"
    remap "__imp__capGetDriverDescriptionA@20" "__imp__avicap32$capGetDriverDescriptionA@20"
    remap "__imp__capCreateCaptureWindowW@32" "__imp__avicap32$capCreateCaptureWindowW@32"
    remap "__imp__capCreateCaptureWindowA@32" "__imp__avicap32$capCreateCaptureWindowA@32"
    remap "__imp__AppCleanup@4" "__imp__avicap32$AppCleanup@4"

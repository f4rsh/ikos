; ModuleID = 'asm.c.pp.bc'
source_filename = "asm.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

; CHECK-LABEL: Bundle
; CHECK: target-endianness = little-endian
; CHECK: target-pointer-size = 64 bits
; CHECK: target-triple = x86_64-apple-macosx10.13.0

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
; CHECK: define [4 x si8]* @.str, align 1, init {
; CHECK: #1 !entry !exit {
; CHECK:   store @.str, [37, 100, 10, 0], align 1
; CHECK: }
; CHECK: }

declare i32 @printf(i8*, ...) #2
; CHECK: declare si32 @ar.libc.printf(si8*, ...)

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main() #0 !dbg !8 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !12, metadata !DIExpression()), !dbg !13
  store i32 1, i32* %2, align 4, !dbg !13
  call void @llvm.dbg.declare(metadata i32* %3, metadata !14, metadata !DIExpression()), !dbg !15
  %4 = load i32, i32* %2, align 4, !dbg !16
  %5 = call i32 asm "mov $1, $0\0A\09add $$1, $0", "=r,r,~{dirflag},~{fpsr},~{flags}"(i32 %4) #3, !dbg !17, !srcloc !18
  store i32 %5, i32* %3, align 4, !dbg !17
  %6 = load i32, i32* %3, align 4, !dbg !19
  %7 = getelementptr inbounds [4 x i8], [4 x i8]* @.str, i32 0, i32 0, !dbg !20
  %8 = call i32 (i8*, ...) @printf(i8* %7, i32 %6), !dbg !20
  %9 = load i32, i32* %3, align 4, !dbg !21
  ret i32 %9, !dbg !22
}
; CHECK: define si32 @main() {
; CHECK: #1 !entry !exit {
; CHECK:   si32* $1 = allocate si32, 1, align 4
; CHECK:   si32* $2 = allocate si32, 1, align 4
; CHECK:   si32* $3 = allocate si32, 1, align 4
; CHECK:   store $1, 0, align 4
; CHECK:   store $2, 1, align 4
; CHECK:   si32 %4 = load $2, align 4
; CHECK:   si32 %5 = call asm "mov $1, $0
; CHECK: 	add $$1, $0"(%4)
; CHECK:   store $3, %5, align 4
; CHECK:   si32 %6 = load $3, align 4
; CHECK:   si8* %7 = ptrshift @.str, 4 * 0, 1 * 0
; CHECK:   si32 %8 = call @ar.libc.printf(%7, %6)
; CHECK:   si32 %9 = load $3, align 4
; CHECK:   return %9
; CHECK: }
; CHECK: }

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "asm.c", directory: "/Users/marthaud/ikos/ikos-git/frontend/llvm/test/regression/import/no_optimization")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!8 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !9, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "src", scope: !8, file: !1, line: 4, type: !11)
!13 = !DILocation(line: 4, column: 7, scope: !8)
!14 = !DILocalVariable(name: "dst", scope: !8, file: !1, line: 5, type: !11)
!15 = !DILocation(line: 5, column: 7, scope: !8)
!16 = !DILocation(line: 10, column: 13, scope: !8)
!17 = !DILocation(line: 7, column: 3, scope: !8)
!18 = !{i32 68, i32 81}
!19 = !DILocation(line: 12, column: 18, scope: !8)
!20 = !DILocation(line: 12, column: 3, scope: !8)
!21 = !DILocation(line: 13, column: 10, scope: !8)
!22 = !DILocation(line: 13, column: 3, scope: !8)

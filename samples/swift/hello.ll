; ModuleID = 'samples/swift/hello-canonical.ll'
source_filename = "samples/swift/hello-canonical.ll"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%swift.type = type { i64 }
%swift.protocol = type { i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i32, i32, i16, i16, i32 }
%swift.refcounted = type { %swift.type*, i64 }
%Ts27_ContiguousArrayStorageBaseC = type <{ %swift.refcounted, %Ts10_ArrayBodyV }>
%Ts10_ArrayBodyV = type <{ %TSC22_SwiftArrayBodyStorageV }>
%TSC22_SwiftArrayBodyStorageV = type <{ %TSi, %TSu }>
%TSi = type <{ i64 }>
%TSu = type <{ i64 }>

@_T0s23_ContiguousArrayStorageCyypGML = linkonce_odr hidden local_unnamed_addr global %swift.type* null, align 8
@_T0ypML = linkonce_odr hidden local_unnamed_addr global %swift.type* null, align 8
@_swift_getExistentialTypeMetadata = external local_unnamed_addr global %swift.type* (i1, %swift.type*, i64, %swift.protocol**)*
@_swift_allocObject = external local_unnamed_addr global %swift.refcounted* (%swift.type*, i64, i64)*
@_T0s27_ContiguousArrayStorageBaseC16countAndCapacitys01_B4BodyVvpWvd = external local_unnamed_addr global i64, align 8
@_T0SSN = external global %swift.type, align 8
@0 = private unnamed_addr constant [7 x i8] c"Hello!\00"
@__swift_reflection_version = linkonce_odr hidden constant i16 3
@_swift1_autolink_entries = private constant [12 x i8] c"-lswiftCore\00", section ".swift1_autolink_entries", align 8
@llvm.used = appending global [2 x i8*] [i8* bitcast (i16* @__swift_reflection_version to i8*), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @_swift1_autolink_entries, i32 0, i32 0)], section "llvm.metadata"

define protected i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
entry:
  %protocols.i.i = alloca [0 x %swift.protocol*], align 8
  %2 = load %swift.type*, %swift.type** @_T0s23_ContiguousArrayStorageCyypGML, align 8
  %3 = icmp eq %swift.type* %2, null
  br i1 %3, label %cacheIsNull.i, label %_T0s23_ContiguousArrayStorageCyypGMa.exit

cacheIsNull.i:                                    ; preds = %entry
  %4 = load %swift.type*, %swift.type** @_T0ypML, align 8
  %5 = icmp eq %swift.type* %4, null
  br i1 %5, label %cacheIsNull.i.i, label %_T0ypMa.exit.i

cacheIsNull.i.i:                                  ; preds = %cacheIsNull.i
  %6 = bitcast [0 x %swift.protocol*]* %protocols.i.i to i8*
  call void @llvm.lifetime.start.p0i8(i64 0, i8* nonnull %6) #5
  %7 = getelementptr inbounds [0 x %swift.protocol*], [0 x %swift.protocol*]* %protocols.i.i, i64 0, i64 0
  %8 = call %swift.type* @swift_rt_swift_getExistentialTypeMetadata(i1 true, %swift.type* null, i64 0, %swift.protocol** nonnull %7) #5
  call void @llvm.lifetime.end.p0i8(i64 0, i8* nonnull %6) #5
  store atomic %swift.type* %8, %swift.type** @_T0ypML release, align 8
  br label %_T0ypMa.exit.i

_T0ypMa.exit.i:                                   ; preds = %cacheIsNull.i.i, %cacheIsNull.i
  %9 = phi %swift.type* [ %4, %cacheIsNull.i ], [ %8, %cacheIsNull.i.i ]
  %10 = call %swift.type* @_T0s23_ContiguousArrayStorageCMa(%swift.type* %9) #6
  store atomic %swift.type* %10, %swift.type** @_T0s23_ContiguousArrayStorageCyypGML release, align 8
  br label %_T0s23_ContiguousArrayStorageCyypGMa.exit

_T0s23_ContiguousArrayStorageCyypGMa.exit:        ; preds = %entry, %_T0ypMa.exit.i
  %11 = phi %swift.type* [ %2, %entry ], [ %10, %_T0ypMa.exit.i ]
  %12 = bitcast %swift.type* %11 to i8*
  %13 = getelementptr inbounds %swift.type, %swift.type* %11, i64 6
  %14 = bitcast %swift.type* %13 to i32*
  %15 = load i32, i32* %14, align 8
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds i8, i8* %12, i64 52
  %18 = bitcast i8* %17 to i16*
  %19 = load i16, i16* %18, align 4
  %20 = add nuw nsw i64 %16, 7
  %21 = and i64 %20, 8589934584
  %22 = add nuw nsw i64 %21, 32
  %23 = or i16 %19, 7
  %24 = zext i16 %23 to i64
  %25 = call noalias %swift.refcounted* @swift_rt_swift_allocObject(%swift.type* %11, i64 %22, i64 %24) #5
  %26 = bitcast %swift.refcounted* %25 to %Ts27_ContiguousArrayStorageBaseC*
  %offset = load i64, i64* @_T0s27_ContiguousArrayStorageBaseC16countAndCapacitys01_B4BodyVvpWvd, align 8
  %27 = bitcast %swift.refcounted* %25 to i8*
  %28 = getelementptr inbounds i8, i8* %27, i64 %offset
  %29 = bitcast i8* %28 to <2 x i64>*
  store <2 x i64> <i64 1, i64 2>, <2 x i64>* %29, align 8
  %30 = getelementptr inbounds %swift.refcounted, %swift.refcounted* %25, i64 2
  %31 = getelementptr inbounds %swift.refcounted, %swift.refcounted* %25, i64 3, i32 1
  %32 = bitcast i64* %31 to %swift.type**
  store %swift.type* @_T0SSN, %swift.type** %32, align 8
  %33 = bitcast %swift.refcounted* %30 to <2 x i64>*
  store <2 x i64> <i64 ptrtoint ([7 x i8]* @0 to i64), i64 6>, <2 x i64>* %33, align 8
  %._core._owner = getelementptr inbounds %swift.refcounted, %swift.refcounted* %25, i64 3
  %34 = bitcast %swift.refcounted* %._core._owner to i64*
  store i64 0, i64* %34, align 8
  %35 = call swiftcc { i64, i64, i64 } @_T0s5printyypd_SS9separatorSS10terminatortFfA0_()
  %36 = extractvalue { i64, i64, i64 } %35, 0
  %37 = extractvalue { i64, i64, i64 } %35, 1
  %38 = extractvalue { i64, i64, i64 } %35, 2
  %39 = call swiftcc { i64, i64, i64 } @_T0s5printyypd_SS9separatorSS10terminatortFfA1_()
  %40 = extractvalue { i64, i64, i64 } %39, 0
  %41 = extractvalue { i64, i64, i64 } %39, 1
  %42 = extractvalue { i64, i64, i64 } %39, 2
  call swiftcc void @_T0s5printyypd_SS9separatorSS10terminatortF(%Ts27_ContiguousArrayStorageBaseC* %26, i64 %36, i64 %37, i64 %38, i64 %40, i64 %41, i64 %42)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: noinline nounwind readonly
define linkonce_odr hidden %swift.type* @swift_rt_swift_getExistentialTypeMetadata(i1, %swift.type*, i64, %swift.protocol**) local_unnamed_addr #2 {
entry:
  %load = load %swift.type* (i1, %swift.type*, i64, %swift.protocol**)*, %swift.type* (i1, %swift.type*, i64, %swift.protocol**)** @_swift_getExistentialTypeMetadata, align 8
  %4 = tail call %swift.type* %load(i1 %0, %swift.type* %1, i64 %2, %swift.protocol** %3) #5
  ret %swift.type* %4
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

declare %swift.type* @_T0s23_ContiguousArrayStorageCMa(%swift.type*) local_unnamed_addr #0

; Function Attrs: noinline nounwind
define linkonce_odr hidden %swift.refcounted* @swift_rt_swift_allocObject(%swift.type*, i64, i64) local_unnamed_addr #3 {
entry:
  %load = load %swift.refcounted* (%swift.type*, i64, i64)*, %swift.refcounted* (%swift.type*, i64, i64)** @_swift_allocObject, align 8
  %3 = tail call %swift.refcounted* %load(%swift.type* %0, i64 %1, i64 %2) #5
  ret %swift.refcounted* %3
}

; Function Attrs: noinline
declare swiftcc { i64, i64, i64 } @_T0s5printyypd_SS9separatorSS10terminatortFfA0_() local_unnamed_addr #4

; Function Attrs: noinline
declare swiftcc { i64, i64, i64 } @_T0s5printyypd_SS9separatorSS10terminatortFfA1_() local_unnamed_addr #4

; Function Attrs: noinline
declare swiftcc void @_T0s5printyypd_SS9separatorSS10terminatortF(%Ts27_ContiguousArrayStorageBaseC*, i64, i64, i64, i64, i64, i64) local_unnamed_addr #4

attributes #0 = { "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { noinline nounwind readonly }
attributes #3 = { noinline nounwind }
attributes #4 = { noinline "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readnone }

!llvm.linker.options = !{}
!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 4, !"Objective-C Garbage Collection", i32 1536}
!2 = !{i32 1, !"Swift Version", i32 6}

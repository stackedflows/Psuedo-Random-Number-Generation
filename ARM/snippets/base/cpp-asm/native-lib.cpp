#include <jni.h>
#include <string>

extern "C" {
    jint multiply(jint a, jint b);
}
extern "C" JNIEXPORT jstring JNICALL
Java_com_example_asmsum_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    int k = multiply(5,9);
    std::string out = std::to_string(k);
    return env->NewStringUTF(out.c_str());
}
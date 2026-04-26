## What is CFlat?

CFlat is a modern **C dialect** that enhances the C language with:

- **RAII (Resource Acquisition Is Initialization)**  
- **Automatic cleanup and resource management**  
- **Safer memory patterns**  
- **Cleaner syntax for common operations**  
- **Optional modern features without sacrificing C’s performance**

CFlat stays close to C’s design philosophy while smoothing out many of its rough edges.



**CFlat example**

**lib.cf **

```c 

#include <cflib.h>
#include<string.h>




#macro test(T)

int r##T =5;

#endm








#macro opt(T)  struct 
{
    T value;
    bool has_value;
};

#endm


#macro DEFVEC2(T,N)


typedef struct {
    T x;
    T y;
    char _pad[ N ];
}  _vec2##T ; 


#endm

#macro _vector(T) 

typedef struct {
  T * data;
  size_t cap;
  size_t len;
} vec##T ;

static inline void vec##T##_push( vec##T *vec  , T value) {

  vec->len++;
  if (vec->len >= vec->cap) {

    vec->cap +=10;

    void * ptr = realloc(vec->data,vec->cap * sizeof(T) );
    if  (ptr){
      vec->data = ptr;

vec->data[vec->len-1]  = value;

    }
 

  }

}


static inline void vec##T##_remove(vec##T *vec, size_t idx) {

    if (idx >= vec->len) {
        return;
    }

  
    if (idx < vec->len - 1) {
        memmove(
            &vec->data[idx],
            &vec->data[idx + 1],
            (vec->len - idx - 1) * sizeof(T)
        );
    }

    vec->len--;
}


static inline  void vec_cu_##T (void *ptr) {
 vec##T *vec = ( vec##T  * ) ptr;

  free(vec->data);
  vec->data = NULL;
  vec->len = 0;
  vec->cap = 0;

}

static inline vec##T  vec##T##_init() {
  vec##T vec;
vec.data = malloc(sizeof(T) * 10);
vec.cap = 10;
vec.len = 0;
return vec;

}


#endm





#define vec_new(T, N)  vec##T N  = vec##T##_init() ;mfcu(vec_cu_##T, &N)

#define vec_push(T, v, x) vec##T##_push( & v, x)

#define vec_at(vec,idx) vec -> data[ idx ] 

#define vec_remove(T,v,idx) vec##T##_remove( &v , idx )


_vector(int)

_vector(float)

_vector(u8)





**main.cf**

```c





#include<stdio.h>
#include<stdint.h>
#include<stdlib.h>
#include<cflib.h>

#include "lib.cf"








void my_free(void *tr) {
    printf("freeing AT  LINE %p\n",tr);
    free(tr);
}


int main()
@{
vec_new(int,t);
vec_push(int,t,4);

vec_remove(int,t,0);


i32 * buffer = malloc(sizeof(i32));
mfcu(my_free,buffer);

{
printf(" welcome to cflat\n");
}

*buffer = 3;

return 0;


printf("hello0");
}

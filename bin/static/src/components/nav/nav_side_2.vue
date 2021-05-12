<template>
  <!-- 侧边导航 -->
  <div class="nav_side">
    <!-- 一级 -->
    <div class="nav_item" v-for="(o,i) in list" :key="i">
      <a class="btn_nav" :href="o.url" @click="open_sub(o,i)">
        <i :class="o.icon" v-if="o.icon"></i>
        <span>{{o.title}}</span>
        <i class="arrow_nav" :class="{rotate:key_rotate === i,rotate_back:key_rotate !== i}" v-if="has_sub(o)"></i>
      </a>
      <!-- 二级 -->
      <div class="sub_list" v-if="has_sub(o)" :style="get_height(o,i)">
        <div @click="close_sub" class="sub_item" v-for="(obj,idx) in o.sub">
          <a class="btn_nav" :href="obj.url">
            <i :class="obj.icon" v-if="obj.icon"></i>
            <span>{{obj.title}}</span>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import mixin from '/src/mixins/component.js'
  export default {
    mixins: [mixin],
    props: {
      list: {
        type: Array,
        default () {
          return [{
              title: "item1",
              url: "#",
              icon: "fa-map-marker"
            },
            {
              title: "item2",
              url: "#",
              icon: "fa-th-large",
              sub: [{
                  title: "sub_item1",
                  url: "#",
                },
                {
                  title: "sub_item1",
                  url: "#",
                },
                {
                  title: "sub_item1",
                  url: "#",
                },
                {
                  title: "sub_item1",
                  url: "#",
                },
              ]
            },
            {
              title: "item3",
              url: "#",
              icon: "fa-file-text-o",
              sub: [{
                  title: "sub_item1",
                  url: "#",
                },
                {
                  title: "sub_item1",
                  url: "#",
                },
                {
                  title: "sub_item1",
                  url: "#",
                }
              ]
            },
            {
              title: "item4",
              url: "#",
              icon: "fa-cog",
            },
            {
              title: "跳转自动关闭导航",
              url: "#",
              icon: "fa-close"
            },
          ]
        },
      },
    },
    data() {
      return {
        // 控制下拉
        list_drop: [],
        // 控制箭头旋转
        key_rotate: -1
      };
    },
    methods: {
      // 打开折叠
      open_sub(o, i) {
        var list_drop = this.list_drop
        var key_rotate = this.key_rotate
        if (o.sub && o.sub.length) {
          if (list_drop.indexOf(i) === -1) {
            list_drop.push(i)
            key_rotate = i
          } else {
            list_drop.del(i)
            key_rotate = -1
          }
        }
        this.list_drop = list_drop
        this.key_rotate = key_rotate
      },
      // 关闭折叠
      close_sub(){
        this.list_drop = []
        this.key_rotate = -1
      },
      // 获取折叠高度
      get_height(o, i) {
        if (this.list_drop.indexOf(i) !== -1) {
          if (this.has_sub(o)) {
            var height = 2.75 * o.sub.length;
            return 'height:' + height + 'rem;'
          }
        }

      },
      // 判断是否有子导航
      has_sub(o) {
        return o.sub && o.sub.length
      },
    },
  };
</script>

<style scoped>
</style>

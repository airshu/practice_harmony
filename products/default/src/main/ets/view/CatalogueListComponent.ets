import { router } from '@kit.ArkUI';
import { CommonConstants } from '../constants/CommonConstants';
import { CatalogueItemData } from '../viewmodel/CatalogueItemData';
import { emitter } from '@kit.BasicServicesKit';
import { taskpool } from '@kit.ArkTS';
import CollectionUtil from '../util/CollectionUtil';
import AsyncLockUtil from '../util/AsyncLockUtil';
import ProcessUtil from '../util/ProcessUtil';
import JSONUtil from '../util/JSONUtil';

@Concurrent
function printArgs(args: number): number {
  console.info("printArgs: " + args);

  return args;

}

@Component
export struct CatalogueListComponent {
  catalogue: CatalogueItemData[] = [];


  build() {
    Column() {
      Button() {
        Text('测试eventHub').fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
      }.onClick(() => {
        emitter.emit('onTest')
        getContext(this).eventHub.emit('onTest1')
        this.getUIContext()
      }).margin({bottom: 10}).height(50).padding({left: 10, right: 10})
      Button() {
        Text('taskpool').fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
      }.onClick(() => {
        // 回调方法；
        taskpool.execute(printArgs, 1).then((result) => {
          console.info("taskpool result: " + result);
        });
        let task = new taskpool.Task(printArgs, 10);


        taskpool.execute(task, taskpool.Priority.HIGH).then((result) => {
          console.info("taskpool 优先级方法 result: " + result);
        });
      }).margin({bottom: 10}).height(50).padding({left: 10, right: 10})

      Button() {
        Text('测试collection').fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
      }.onClick(() => {
        // CollectionUtil.instance.testArray()
        // CollectionUtil.instance.testMap()
        // AsyncLockUtil.instance.test();
        // ProcessUtil.instance.test();
        JSONUtil.instance.test();
      }).margin({bottom: 10}).height(50).padding({left: 10, right: 10})
      GridRow({
        columns: {
          xs: CommonConstants.COLUMN_XS,
          sm: CommonConstants.COLUMN_SM,
          md: CommonConstants.COLUMN_MD,
          lg: CommonConstants.COLUMN_LG
        }
      }) {
        GridCol({
          span: {
            xs: CommonConstants.SPAN_XS,
            sm: CommonConstants.SPAN_SM,
            md: CommonConstants.SPAN_MD,
            lg: CommonConstants.SPAN_LG
          },
          offset: {
            xs: CommonConstants.OFFSET_XS,
            sm: CommonConstants.OFFSET_SM,
            md: CommonConstants.OFFSET_MD,
            lg: CommonConstants.OFFSET_LG
          }
        }) {
          List() {
            ForEach(this.catalogue, (item: CatalogueItemData) => {
              ListItem() {
                Text(item.title)
                  .fontSize($r('app.float.catalogue_text_font_size'))
                  .fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
                  .fontWeight(CommonConstants.LIST_FONT_WEIGHT)
              }
              .backgroundColor($r('sys.color.ohos_id_color_emphasize'))
              .width(CommonConstants.LIST_ITEM_WIDTH)
              .height($r('app.float.catalogue_list_item_height'))
              .margin({ bottom: $r('app.float.catalogue_list_item_margin_bottom') })
              .borderRadius($r('app.float.catalogue_list_item_border_radius'))
              .onClick(() => {
                router.pushUrl({
                  url: item.uri,
                  params: {
                    data: item.params
                  }
                })
              })
            }, (item: CatalogueItemData, index?: number) => index + JSON.stringify(item))
          }
          .width(CommonConstants.LIST_WIDTH)
          .height($r('app.float.catalogue_list_height'))
          .scrollBar(BarState.Off)
        }
      }
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height(CommonConstants.COLUMN_HEIGHT)
    .margin({
      left: $r('app.float.catalogue_list_margin_left'),
      right: $r('app.float.catalogue_list_margin_right')
    })
  }
}
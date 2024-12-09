import { router } from '@kit.ArkUI';
import { CommonConstants } from '../constants/CommonConstants';
import { CatalogueItemData } from '../viewmodel/CatalogueItemData';
import { emitter } from '@kit.BasicServicesKit';
import { taskpool } from '@kit.ArkTS';
import CollectionUtil from '../util/CollectionUtil';
import AsyncLockUtil from '../util/AsyncLockUtil';
import ProcessUtil from '../util/ProcessUtil';
import JSONUtil from '../util/JSONUtil';
import { notificationManager } from '@kit.NotificationKit';
import { WantAgent, wantAgent } from '@kit.AbilityKit';
import { abilityAccessCtrl, bundleManager, common, Permissions } from '@kit.AbilityKit';

@Concurrent
function printArgs(args: number): number {
  console.info("printArgs: " + args);

  return args;

}

@Component
export struct CatalogueListComponent {
  catalogue: CatalogueItemData[] = [];
  notificationId: number = 111;

  async getProjectName(): Promise<string> {


    let test:string = "{name:'xiaoming' age:10}";
    let result:object = JSON.parse(test);

    $r("app.string.ability_label");
    let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
    bundleInfo.name;
    return "";
  }

  async testNotification() {
    let xxx = await this.getProjectName();

    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: "com.willshine.practice_harmony",
          abilityName: "DefaultAbility",
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,
      requestCode: 100
    };

    let wantAgentObj: WantAgent = await wantAgent.getWantAgent(wantAgentInfo);

    let notificationRequest: notificationManager.NotificationRequest = {
      id: this.notificationId,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: '录音',
          text: '正在录音中'
        },
      },
      wantAgent: wantAgentObj,
      notificationSlotType: notificationManager.SlotType.OTHER_TYPES,
    };
    notificationManager.publish(notificationRequest);

  }

  cancelNotification() {
    notificationManager.cancel(this.notificationId);
  }

  build() {
    Column() {
      Button() {
        Text('测试eventHub').fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
      }.onClick(() => {
        emitter.emit('onTest')
        getContext(this).eventHub.emit('onTest1')
        this.getUIContext()
      }).margin({ bottom: 10 }).height(50).padding({ left: 10, right: 10 })

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
      }).margin({ bottom: 10 }).height(50).padding({ left: 10, right: 10 })

      Button() {
        Text('测试collection').fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
      }.onClick(() => {
        this.testNotification()
      }).margin({ bottom: 10 }).height(50).padding({ left: 10, right: 10 })

      Button() {
        Text('打开系统通知栏').fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
      }.onClick(() => {
        this.testNotification();
      }).margin({ bottom: 10 }).height(50).padding({ left: 10, right: 10 })

      Button() {
        Text('关闭系统通知栏').fontColor($r('sys.color.ohos_id_color_text_primary_contrary'))
      }.onClick(() => {
        this.cancelNotification()
      }).margin({ bottom: 10 }).height(50).padding({ left: 10, right: 10 })


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
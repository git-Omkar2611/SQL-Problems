import asyncio

async def main():
    task = asyncio.create_task(other_function())
    print('A')
    await asyncio.sleep(5)
    print('B')
    await task

async def other_function():
    print('1')
    await asyncio.sleep(5)
    print('2')


asyncio.run(main())


# if count < len(cms_queue):
        #     for cms_queue_key,cms_queue_value in cms_queue.items():
        #         for udu_queue_key,udp_queue_value in udp_queue.items():
        #              if cms_queue_key ==  udu_queue_key and (cms_queue_value == udp_queue_value and cms_queue_value.lower() == 'success') :
        #                 #  task = asyncio.create_task(sendToMerge(cms_queue_key,cms_queue_value))
        #                 #  await task
        #                  print(f"{cms_queue_key} {cms_queue_value}")
        #                  print("*******************")
        #                  print(f"{udu_queue_key} {udp_queue_value}")
        #                  ##sendToMerge(udu_queue_key,udp_queue_value)
        #                  count = count + 1
        # else :
        #     break

#for key, value in cms_queue.items():
    #     if key in udp_queue and udp_queue[key] == value and value.lower() == 'success':
    #         print(f"Key '{key}' and value '{value}' are the same in both dictionaries")
    #     else:
    #         pass
    #         # print(f"Key '{key}' or value '{value}' is different between the dictionaries")
module;

#include <System.h>

#include <condition_variable>
#include <mutex>
#include <string_view>
#include <thread>
#include <queue>
#include <functional>

export module AsyncTaskQueue;


export class LOG20_API AsyncTaskQueue
{
public:

	using Task = std::function<void()>;

	AsyncTaskQueue();

	~AsyncTaskQueue();

	void enqueue(Task&& task);

	void flush();

private:

	void run();

	bool mExit{ false };

	std::condition_variable mConditionalVariable;

	std::mutex mQueueProtection;

	std::queue<std::function<void()>> mQueue;

	std::thread mThread;
};
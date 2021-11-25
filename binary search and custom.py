# Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where 
# it would be if it were inserted in order.

# You must write an algorithm with O(log n) runtime complexity.
# Input: nums = [1,3,5,6], target = 5
# Output: 2


# SOlution - Binary Search and custom logic.

class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        # if target in nums:
        #     for i in range(len(nums)):
        #         if target == nums[i]:
        #             return i
        # else:
        #     nums.append(target)
        #     nums[:] = sorted(nums)
        #     for i in range(len(nums)):
        #         if target == nums[i]:
        #             return i
        
        beg,end = 0, len(nums)-1
        
        while beg < end:
            mid = (beg+end)//2
            if nums[mid] >= target:
                end = mid
            else:
                beg = mid+1
        return beg